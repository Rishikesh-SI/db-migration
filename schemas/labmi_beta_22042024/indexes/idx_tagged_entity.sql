-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: idx_tagged_entity
-- Type: INDEX

-- Name: idx_tagged_entity; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX idx_tagged_entity ON labmi_beta_22042024.labmi_asset_list USING gin (tagged_entity);


--
