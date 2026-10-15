-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labbsc_old; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labbsc_old.labbsc_template_component_map USING btree (component_id);


--
