-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labrr_beta_08042024; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labrr_beta_08042024.labrr_template_component_map USING btree (template_id);


--
