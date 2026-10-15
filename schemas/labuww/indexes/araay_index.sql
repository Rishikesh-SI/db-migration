-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: araay_index
-- Type: INDEX

-- Name: araay_index; Type: INDEX; Schema: labuww; Owner: -
--

CREATE INDEX araay_index ON labuww.labuww_template_component_data USING gin (tagged_entity);


--
