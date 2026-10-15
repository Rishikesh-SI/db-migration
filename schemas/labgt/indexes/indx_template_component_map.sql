-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: indx_template_component_map
-- Type: INDEX

-- Name: indx_template_component_map; Type: INDEX; Schema: labgt; Owner: -
--

CREATE INDEX indx_template_component_map ON labgt.labgt_template_component_data USING brin (template_component_map_id);


--
