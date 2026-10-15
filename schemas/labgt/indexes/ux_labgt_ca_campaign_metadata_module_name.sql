-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: ux_labgt_ca_campaign_metadata_module_name
-- Type: INDEX

-- Name: ux_labgt_ca_campaign_metadata_module_name; Type: INDEX; Schema: labgt; Owner: -
--

CREATE UNIQUE INDEX ux_labgt_ca_campaign_metadata_module_name ON labgt.labgt_ca_campaign_metadata USING btree (lower(module_name));


--
