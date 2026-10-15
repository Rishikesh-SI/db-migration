-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: araay_index
-- Type: INDEX

-- Name: araay_index; Type: INDEX; Schema: labkxip; Owner: -
--

CREATE INDEX araay_index ON labkxip.labkxip_template_component_data USING gin (tagged_entity);


--
