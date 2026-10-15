-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: araay_index
-- Type: INDEX

-- Name: araay_index; Type: INDEX; Schema: labbg; Owner: -
--

CREATE INDEX araay_index ON labbg.labbg_template_component_data USING gin (tagged_entity);


--
