-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_get_correct_answer labpr_get_correct_answer_pkey
-- Type: CONSTRAINT

-- Name: labpr_get_correct_answer labpr_get_correct_answer_pkey; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_get_correct_answer
    ADD CONSTRAINT labpr_get_correct_answer_pkey PRIMARY KEY (q_id);


--
