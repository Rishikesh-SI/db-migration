-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: indx_template_component_map
-- Type: INDEX

-- Name: indx_template_component_map; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX indx_template_component_map ON labw88.labw88_template_component_data USING brin (template_component_map_id);


--
