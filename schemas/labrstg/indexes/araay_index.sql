-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: araay_index
-- Type: INDEX

-- Name: araay_index; Type: INDEX; Schema: labrstg; Owner: -
--

CREATE INDEX araay_index ON labrstg.labrstg_template_component_data USING gin (tagged_entity);


--
