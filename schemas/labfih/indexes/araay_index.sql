-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: araay_index
-- Type: INDEX

-- Name: araay_index; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX araay_index ON labfih.labfih_template_component_data USING gin (tagged_entity);


--
