-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: araay_index
-- Type: INDEX

-- Name: araay_index; Type: INDEX; Schema: labeisl; Owner: -
--

CREATE INDEX araay_index ON labeisl.labeisl_template_component_data USING gin (tagged_entity);


--
