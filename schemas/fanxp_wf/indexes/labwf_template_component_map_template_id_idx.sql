-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_template_component_map_template_id_idx
-- Type: INDEX

-- Name: labwf_template_component_map_template_id_idx; Type: INDEX; Schema: fanxp_wf; Owner: -
--

CREATE INDEX labwf_template_component_map_template_id_idx ON fanxp_wf.labwf_template_component_map USING btree (template_id);


--
