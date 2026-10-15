-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_asset_delete_log labmsg_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labmsg_asset_delete_log labmsg_asset_delete_log_id; Type: CONSTRAINT; Schema: labmsg; Owner: -
--

ALTER TABLE ONLY labmsg.labmsg_asset_delete_log
    ADD CONSTRAINT labmsg_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
