-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: idx_labbg_template_id
-- Type: INDEX

-- Name: idx_labbg_template_id; Type: INDEX; Schema: labbg; Owner: -
--

CREATE INDEX idx_labbg_template_id ON labbg.labbg_template_component_data USING btree (template_id DESC NULLS LAST);


--
