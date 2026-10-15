-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: araay_index
-- Type: INDEX

-- Name: araay_index; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX araay_index ON labw88.labw88_template_component_data USING gin (tagged_entity);


--
