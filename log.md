## Day 1 · Setup + business questions

**Did**
- Created GitHub, Kaggle and LinkedIn accounts
- Set up Excel; downloaded "Sample - Superstore" from Kaggle (version with Order Date, ~9,994 rows)
- Created the `learning-log` repo
- Explored the columns and wrote 3 business questions

**Lessons**
- A business question leads to a decision, not just a number
- Formula: "Which [group] has the highest/lowest [metric], and what should we do about it?"
- Every question needs a dimension (State, Region, Category, date) and a metric (Sales, Profit, Discount)
- Check the column exists before asking: Quantity is units ordered (demand), not supply
- One row = one product line within an order
- Asking the right questions - 
A business question is one a manager would ask to make a decision, and that your data can actually answer. It’s not “what’s in the data?” but “what should we do?”
- A good one has three parts:

A decision behind it: someone could act on the answer (cut, invest, change a price, fix a process).
Specific: it names what to measure and how to slice it.
Answerable with your columns: if the data doesn’t have it, it’s not a question for this dataset.
A simple formula to start with: “Which [group] has the highest/lowest [metric], and what should we do about it?”

**Final questions (basis for project B1)**
1. Which product sub-categories lose money overall, and is heavy discounting the cause? Should we cap discounts on them?
2. Which states generate high sales but negative profit, and what's driving the losses there?
3. Which months are consistently strongest and weakest for sales and profit, and how should we plan around that?

## Day 2 · Formulas

**Did**
- Relative (A1), absolute ($A$1) and mixed ($A1, A$1) references; F4 to toggle (Cmd + T on Mac)
- SUMIFS, AVERAGEIFS, COUNTIFS on Superstore
- SUMIF vs SUMIFS: different argument order → default to SUMIFS
- Built a region table: Sales, Profit, Margin, Avg Discount, Loss-Making Lines, Share
- Completed 15 formula exercises

**Lessons**
- Bug found: unlocked ranges slid down when dragged, so South and West totals were wrong
  with no error shown → lock data ranges with $
- Put criteria in a cell (T2) instead of typing text, then drag
- Compare rates, not raw counts, when groups differ in size
- Say "consistent with", not "caused by"
- Sanity-check every number: sales can't be negative; you can't add percentages
- Overall margin = SUM(profit) ÷ SUM(sales), not the average of row margins
- Check both direction and size when comparing groups (per line vs margin)
- Label columns precisely ("Order Lines", not "Total Profits")

**Finding: regions**
| Region | Sales | Profit | Margin | Avg Discount | Loss-Making Lines |
|---|---|---|---|---|---|
| Central | $501,240 | $39,706 | 7.9% | 24.0% | 31.9% |
| East | $678,781 | $91,523 | 13.5% | 14.5% | 19.4% |
| South | $391,722 | $46,749 | 11.9% | 14.7% | 16.0% |
| West | $725,458 | $108,418 | 14.9% | 10.9% | 9.9% |

**Other findings (exercises)**
- Total: $2,297,201 sales, $286,397 profit, 12.5% margin
- Lines with discount > 30% lost $125,007
- Biggest single loss: −$6,600 on a 3D printer sold at 70% off
- Central Furniture: $163,797 sales, −$2,871 profit (−1.8% margin)
- Office Supplies margin 17.0%; 33.7% of Furniture lines lose money
- Home Office is the most efficient segment (14.0% margin vs 11.5% Consumer)

## Day 3 · Lookups, logic, dates and text

**Did**
- IF, nested IF, IFERROR
- New columns: Profit Margin, Profit Status (Loss/Profit), Margin Band (Loss/Low/Healthy)
- XLOOKUP with a target-margin table per region + "Not found" fallback
- VLOOKUP version of the same lookup; check column → 0 mismatches
- INDEX/MATCH: the older way to look left
- Dates: YEAR, MONTH, TEXT(date, "mmm"); Days to Ship = Ship Date − Order Date
- Text: MID to pull the year out of Order IDs

**Lessons**
- Boundary bug: `>10%` put exactly 10% in the wrong band → test edge values; use `<` from low to high
- XLOOKUP beats VLOOKUP: looks left, no hard-coded column number, exact match by default
- Always use FALSE in VLOOKUP unless you want approximate match
- MID returns text ("2016"), YEAR returns a number (2016) → wrap in VALUE() to compare
- Debug a formula by testing it in pieces
- ISNUMBER confirms dates are real dates (watch US vs Indian date formats)

**Findings**
- “Central Furniture: $163,797 sales, −$2,871 profit (−1.8% margin).”
- Deep discounts (above 30%) lost $125K, against $286K total profit.
- Central has the highest discounts (24%) and the lowest margin (7.9%).
- Furniture is the weak category: 1 in 3 lines loses money, and Central Furniture runs at −1.8%

**Checks**
- Loss rows = 1,871, matches Day 2 regional counts (741 + 553 + 259 + 318)
- Below + Met target = 9,994 (every row classified)
- Order ID year vs Order Year → 0 mismatches
- Average Days to Ship ≈ 4 days



## Day 4 · Data cleaning

**Did**
- Worked on a copy (`clean` sheet), never the original
- Duplicates: 5,009 unique orders across 9,994 rows (~2 lines per order); repeated Order IDs are normal
- Removed 1 exact duplicate row (all fields identical except Row ID), treated as a double entry
- Blanks: COUNTBLANK per column → 0 in every column
- Data types: ISNUMBER on Sales, Quantity, Discount, Profit → 9,993 / 9,993 real numbers
- Hidden spaces: LEN vs TRIM check → 0
- Built a Discount Band column with VLOOKUP approximate match (sorted lookup table)

**Lessons**
- A duplicate depends on what one row represents
- Hard-coded ranges break when rows change → use Excel Tables (Ctrl + T)
- Know what a passing check should return (9,993, not 0)
- Missing values can hide as "N/A", "-", or 0
- Document every cleaning decision

**Finding**
| Band | Lines | Profit | Margin |
|---|---|---|---|
| 0% | 4,798 | $320,988 | 29.5% |
| 1–20% | 3,803 | $100,785 | 11.9% |
| 21–40% | 459 | −$35,805 | −15.3% |
| Over 40% | 933 | −$99,559 | −77.4% |

Discounts above 20% lose money. Lines over 40% off are 9% of orders but lost ~$100K.
Capping discounts at 20% could protect up to ~$135K (assumes customers still buy).

## Day 5 · Pivot tables, charts and slicers

**Did**
- Turned the clean data into an Excel Table (Ctrl + T) and built pivots from it
- Rebuilt the region table as a pivot: Sum of Sales/Profit, Count of Order ID, Average Discount
- Checked against Day 2: only East changed (the removed duplicate was an East order)
- Built a Category × Region pivot (two dimensions at once)
- Calculated margins next to the pivot (Excel for the web has no calculated fields)
- Made two finding-style charts: margin by discount band, and margin by category × region
- Added slicers for Order Year and Region

**Lessons**
- Never put a row-level margin column in pivot Values: summing or averaging it is wrong
- Two-dimensional views reveal what one-dimension tables hide
- Chart titles state the finding, not the topic
- Bar charts with negative values: set axis label position to Low
- Horizontal bars list from the bottom up: use "Categories in reverse order"
- When data labels show every value, remove the axis and add a subtitle saying what the numbers are
- Colour only what the title is about; mute the rest
- When a tool can't format something, reshape the data (Profit/Loss helper columns)
- Keep charts in the same file as their data, or they become external links
- Slicers filter pivots, not SUMIFS formulas

**Findings: margin by category × region**
| Category | Central | East | South | West | Total |
|---|---|---|---|---|---|
| Furniture | −1.8% | 1.5% | 5.8% | 4.6% | 2.5% |
| Office Supplies | 5.3% | 20.0% | 15.9% | 23.8% | 17.0% |
| Technology | 19.8% | 17.9% | 13.4% | 17.6% | 17.4% |
| All | 7.9% | 13.5% | 11.9% | 14.9% | 12.5% |

- Furniture is under 10% margin in every region; it loses money only in Central (East is next at 1.5%)
- Central trails on two of three categories: Office Supplies earns 5.3% there vs 16–24% elsewhere
- Central Furniture lost money in all four years: −$1,105 (2014), −$231 (2015), −$254 (2016), −$1,281 (2017) = −$2,871
- Consistent but small (~1% of total profit); deep discounts (−$135K) are the bigger problem

## Day 6 · Build B1 (dashboard + GitHub)

**Did**
- Answered all three Day 1 business questions with evidence
- Picked three headline numbers (context, problem, proof) and built a one-page Excel dashboard
- Published B1 to its own repo: README, Dashboard.png, .xlsx
  → https://github.com/swethaamreddy/superstore-profit-analysis

**Findings**
- Q1, sub-categories: Tables (−$17.7K) and Bookcases (−$3.5K) are profitable at ≤20% off
  (11.1%, 8.8% margins) but run −34.1% and −38.9% above it; 176 of 319 Tables lines are discounted >20%
- Q1, Supplies: discounts are low (7.7%); the loss comes from letter openers. None of the 10 products
  makes money (−$2.1K, 2 products = 83%); the rest of Supplies earns +$0.9K
- Q2, states: Texas, Ohio, Pennsylvania, Illinois, North Carolina lose $78K combined, average 28–39% discount,
  never sell at full price; ≤20% lines are profitable in all five; Over 40% lines alone lost $72.4K
- Q3, months: Sep, Nov, Dec peak every year; Feb is slowest but best margin (17.2%);
  Nov's 10.1% margin comes from a few >40% discount orders (3D printer at 70% off: −$6.6K)
- Headline: ≤20% off → 21.8% margin; >20% off → −37.3%; >20% lost $135K vs $286K total profit

**Lessons**
- Test a hypothesis and look for where it breaks (Supplies didn't fit the discount story)
- Materiality: report what changes a decision, note what doesn't, never drop it silently
- An average can look normal while extremes do the damage (November)
- Removing outliers: same rule for every group, or remove only the clear extreme
- Before a number goes on a headline card, check that the parts add up to the whole (−44.2% → −37.3%)
- A recommendation = action + scope + impact + caveat/next step
- Dashboard: headline cards linked to calculation cells, red only for losses, everything aligned
- README.md needs the .md extension to render; image links are case-sensitive
