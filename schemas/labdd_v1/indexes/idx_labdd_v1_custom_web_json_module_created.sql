-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: idx_labdd_v1_custom_web_json_module_created
-- Type: INDEX

-- Name: idx_labdd_v1_custom_web_json_module_created; Type: INDEX; Schema: labdd_v1; Owner: -
--

CREATE INDEX idx_labdd_v1_custom_web_json_module_created ON labdd_v1.labdd_v1_custom_web_json USING btree (lower((module_name)::text), created_date DESC);


--
