-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: indx_template_component_map
-- Type: INDEX

-- Name: indx_template_component_map; Type: INDEX; Schema: labbg; Owner: -
--

CREATE INDEX indx_template_component_map ON labbg.labbg_template_component_data USING brin (template_component_map_id);


--
