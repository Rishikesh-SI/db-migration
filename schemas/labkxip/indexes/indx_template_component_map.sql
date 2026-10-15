-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: indx_template_component_map
-- Type: INDEX

-- Name: indx_template_component_map; Type: INDEX; Schema: labkxip; Owner: -
--

CREATE INDEX indx_template_component_map ON labkxip.labkxip_template_component_data USING brin (template_component_map_id);


--
