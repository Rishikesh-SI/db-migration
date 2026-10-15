-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: araay_index
-- Type: INDEX

-- Name: araay_index; Type: INDEX; Schema: labsaw; Owner: -
--

CREATE INDEX araay_index ON labsaw.labsaw_template_component_data USING gin (tagged_entity);


--
