-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON dd_30_04_24.dd_template_component_map USING btree (component_id);


--
