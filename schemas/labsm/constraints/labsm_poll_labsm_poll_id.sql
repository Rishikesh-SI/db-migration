-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_poll labsm_poll_id
-- Type: CONSTRAINT

-- Name: labsm_poll labsm_poll_id; Type: CONSTRAINT; Schema: labsm; Owner: -
--

ALTER TABLE ONLY labsm.labsm_poll
    ADD CONSTRAINT labsm_poll_id PRIMARY KEY (poll_id);


--
