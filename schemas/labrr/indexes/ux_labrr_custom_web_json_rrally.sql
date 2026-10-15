-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: ux_labrr_custom_web_json_rrally
-- Type: INDEX

-- Name: ux_labrr_custom_web_json_rrally; Type: INDEX; Schema: labrr; Owner: -
--

CREATE UNIQUE INDEX ux_labrr_custom_web_json_rrally ON labrr.labrr_custom_web_json USING btree (user_guid) WHERE (lower((module_name)::text) = 'rrally'::text);


--
