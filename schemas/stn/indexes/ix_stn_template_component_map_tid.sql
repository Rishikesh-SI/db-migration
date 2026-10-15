-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_template_component_map_tid
-- Type: INDEX

-- Name: ix_stn_template_component_map_tid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_template_component_map_tid ON stn.stn_template_component_map USING btree (template_id);


--
