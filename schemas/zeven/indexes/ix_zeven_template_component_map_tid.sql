-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_template_component_map_tid
-- Type: INDEX

-- Name: ix_zeven_template_component_map_tid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_template_component_map_tid ON zeven.zeven_template_component_map USING btree (template_id);


--
