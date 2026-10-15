-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_salary_adjustments_trial_ans
-- Type: TABLE

-- Name: labpr_salary_adjustments_trial_ans; Type: TABLE; Schema: labpr; Owner: -
--

CREATE TABLE labpr.labpr_salary_adjustments_trial_ans (
    id integer NOT NULL,
    employee_name character varying(255),
    original_salary numeric(10,2),
    performance_rating character varying(20),
    salary_increase numeric(10,2),
    new_salary numeric(10,2)
);


--
