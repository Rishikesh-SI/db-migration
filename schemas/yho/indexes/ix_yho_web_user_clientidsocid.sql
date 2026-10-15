-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_web_user_clientidsocid
-- Type: INDEX

-- Name: ix_yho_web_user_clientidsocid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_web_user_clientidsocid ON yho.yho_web_user USING btree (social_id, client_id) WHERE (social_id IS NOT NULL);


--
