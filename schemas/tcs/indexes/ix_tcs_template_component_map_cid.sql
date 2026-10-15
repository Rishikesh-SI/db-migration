-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_template_component_map_cid
-- Type: INDEX

-- Name: ix_tcs_template_component_map_cid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_template_component_map_cid ON tcs.tcs_template_component_map USING btree (component_id);


--
