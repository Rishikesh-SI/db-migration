-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: araay_index
-- Type: INDEX

-- Name: araay_index; Type: INDEX; Schema: labgt_bkp; Owner: -
--

CREATE INDEX araay_index ON labgt_bkp.labgt_template_component_data USING gin (tagged_entity);


--
