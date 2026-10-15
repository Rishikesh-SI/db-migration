-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: indx_template_compo_map_id_n_tem_id
-- Type: INDEX

-- Name: indx_template_compo_map_id_n_tem_id; Type: INDEX; Schema: labsaw; Owner: -
--

CREATE INDEX indx_template_compo_map_id_n_tem_id ON labsaw.labsaw_template_component_map USING btree (template_component_map_id, template_id);


--
