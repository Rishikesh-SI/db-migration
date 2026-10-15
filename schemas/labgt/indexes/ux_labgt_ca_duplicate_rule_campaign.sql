-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: ux_labgt_ca_duplicate_rule_campaign
-- Type: INDEX

-- Name: ux_labgt_ca_duplicate_rule_campaign; Type: INDEX; Schema: labgt; Owner: -
--

CREATE UNIQUE INDEX ux_labgt_ca_duplicate_rule_campaign ON labgt.labgt_ca_duplicate_rule USING btree (campaign_metadata_id);


--
