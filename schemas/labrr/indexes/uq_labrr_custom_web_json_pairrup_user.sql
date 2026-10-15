-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: uq_labrr_custom_web_json_pairrup_user
-- Type: INDEX

-- Name: uq_labrr_custom_web_json_pairrup_user; Type: INDEX; Schema: labrr; Owner: -
--

CREATE UNIQUE INDEX uq_labrr_custom_web_json_pairrup_user ON labrr.labrr_custom_web_json USING btree (user_guid) WHERE (lower((module_name)::text) = 'pairrup'::text);


--
