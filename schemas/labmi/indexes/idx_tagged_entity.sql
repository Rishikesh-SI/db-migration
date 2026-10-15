-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: idx_tagged_entity
-- Type: INDEX

-- Name: idx_tagged_entity; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX idx_tagged_entity ON labmi.labmi_asset_list USING gin (tagged_entity);


--
