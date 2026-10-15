-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_asset_list labmsg_asset_list_id
-- Type: CONSTRAINT

-- Name: labmsg_asset_list labmsg_asset_list_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_asset_list
    ADD CONSTRAINT labmsg_asset_list_id PRIMARY KEY (asset_list_id);


--
