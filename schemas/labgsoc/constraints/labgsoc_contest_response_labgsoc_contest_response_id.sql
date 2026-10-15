-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_contest_response labgsoc_contest_response_id
-- Type: CONSTRAINT

-- Name: labgsoc_contest_response labgsoc_contest_response_id; Type: CONSTRAINT; Schema: labgsoc; Owner: -
--

ALTER TABLE ONLY labgsoc.labgsoc_contest_response
    ADD CONSTRAINT labgsoc_contest_response_id PRIMARY KEY (contest_response_id);


--
