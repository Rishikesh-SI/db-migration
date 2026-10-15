-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: araay_index
-- Type: INDEX

-- Name: araay_index; Type: INDEX; Schema: labgt01_v1; Owner: -
--

CREATE INDEX araay_index ON labgt01_v1.labgt01_v1_template_component_data USING gin (tagged_entity);


--
