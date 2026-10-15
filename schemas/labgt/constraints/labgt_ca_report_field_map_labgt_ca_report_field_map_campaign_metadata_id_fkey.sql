-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ca_report_field_map labgt_ca_report_field_map_campaign_metadata_id_fkey
-- Type: FK CONSTRAINT

-- Name: labgt_ca_report_field_map labgt_ca_report_field_map_campaign_metadata_id_fkey; Type: FK CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_ca_report_field_map
    ADD CONSTRAINT labgt_ca_report_field_map_campaign_metadata_id_fkey FOREIGN KEY (campaign_metadata_id) REFERENCES labgt.labgt_ca_campaign_metadata(id) ON DELETE CASCADE;


--
