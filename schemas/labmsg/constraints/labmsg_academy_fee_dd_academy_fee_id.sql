-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_academy_fee dd_academy_fee_id
-- Type: CONSTRAINT

-- Name: labmsg_academy_fee dd_academy_fee_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_academy_fee
    ADD CONSTRAINT dd_academy_fee_id PRIMARY KEY (academy_fee_id);


--
