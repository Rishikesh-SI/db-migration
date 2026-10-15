-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_template_component_map_cid
-- Type: INDEX

-- Name: ix_yho_template_component_map_cid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_template_component_map_cid ON yho.yho_template_component_map USING btree (component_id);


--
