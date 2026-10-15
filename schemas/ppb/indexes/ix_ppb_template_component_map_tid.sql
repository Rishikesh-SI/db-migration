-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_template_component_map_tid
-- Type: INDEX

-- Name: ix_ppb_template_component_map_tid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_template_component_map_tid ON ppb.ppb_template_component_map USING btree (template_id);


--
