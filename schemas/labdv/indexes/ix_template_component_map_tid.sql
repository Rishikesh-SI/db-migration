-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labdv; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labdv.labdv_template_component_map USING btree (template_id);


--
