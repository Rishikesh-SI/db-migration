-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_poll labdv_poll_id
-- Type: CONSTRAINT

-- Name: labdv_poll labdv_poll_id; Type: CONSTRAINT; Schema: labdv; Owner: -
--

ALTER TABLE ONLY labdv.labdv_poll
    ADD CONSTRAINT labdv_poll_id PRIMARY KEY (poll_id);


--
