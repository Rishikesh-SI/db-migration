-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_poll labrstg_poll_id
-- Type: CONSTRAINT

-- Name: labrstg_poll labrstg_poll_id; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_poll
    ADD CONSTRAINT labrstg_poll_id PRIMARY KEY (poll_id);


--
