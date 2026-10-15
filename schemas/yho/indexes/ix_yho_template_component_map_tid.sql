-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_template_component_map_tid
-- Type: INDEX

-- Name: ix_yho_template_component_map_tid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_template_component_map_tid ON yho.yho_template_component_map USING btree (template_id);


--
