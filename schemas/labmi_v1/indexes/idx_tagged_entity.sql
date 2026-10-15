-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: idx_tagged_entity
-- Type: INDEX

-- Name: idx_tagged_entity; Type: INDEX; Schema: labmi_v1; Owner: -
--

CREATE INDEX idx_tagged_entity ON labmi_v1.labmi_v1_asset_list USING gin (tagged_entity);


--
