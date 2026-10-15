-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: indx_template_component_map
-- Type: INDEX

-- Name: indx_template_component_map; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE INDEX indx_template_component_map ON labpkl_v1.labpkl_v1_template_component_data USING brin (template_component_map_id);


--
