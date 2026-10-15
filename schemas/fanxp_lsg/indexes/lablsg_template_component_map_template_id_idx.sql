-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_template_component_map_template_id_idx
-- Type: INDEX

-- Name: lablsg_template_component_map_template_id_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_template_component_map_template_id_idx ON fanxp_lsg.lablsg_template_component_map USING btree (template_id);


--
