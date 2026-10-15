-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_rating_week tsk_rating_week_id
-- Type: CONSTRAINT

-- Name: tsk_rating_week tsk_rating_week_id; Type: CONSTRAINT; Schema: tsk; Owner: -
--

ALTER TABLE ONLY tsk.tsk_rating_week
    ADD CONSTRAINT tsk_rating_week_id PRIMARY KEY (rating_week_id);


--
