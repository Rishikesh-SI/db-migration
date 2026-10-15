-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_invitation invitation_info_id_pk
-- Type: CONSTRAINT

-- Name: stn_invitation invitation_info_id_pk; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_invitation
    ADD CONSTRAINT invitation_info_id_pk PRIMARY KEY (invitation_id);


--
