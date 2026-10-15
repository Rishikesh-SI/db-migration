-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: araay_index
-- Type: INDEX

-- Name: araay_index; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX araay_index ON labgt.labgt_template_component_data USING gin (tagged_entity);


--
