-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: labtkr_poll labtkr_poll_id
-- Type: CONSTRAINT

-- Name: labtkr_poll labtkr_poll_id; Type: CONSTRAINT; Schema: labtkr_beta; Owner: -
--

ALTER TABLE ONLY labtkr_beta.labtkr_poll
    ADD CONSTRAINT labtkr_poll_id PRIMARY KEY (poll_id);


--
