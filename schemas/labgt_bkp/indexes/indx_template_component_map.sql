-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: indx_template_component_map
-- Type: INDEX

-- Name: indx_template_component_map; Type: INDEX; Schema: labgt_bkp; Owner: -
--

CREATE INDEX indx_template_component_map ON labgt_bkp.labgt_template_component_data USING brin (template_component_map_id);


--
