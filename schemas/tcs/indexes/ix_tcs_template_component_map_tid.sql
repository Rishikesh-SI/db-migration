-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_template_component_map_tid
-- Type: INDEX

-- Name: ix_tcs_template_component_map_tid; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_template_component_map_tid ON tcs.tcs_template_component_map USING btree (template_id);


--
