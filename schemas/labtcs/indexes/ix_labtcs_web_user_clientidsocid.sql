-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_labtcs_web_user_clientidsocid
-- Type: INDEX

-- Name: ix_labtcs_web_user_clientidsocid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_labtcs_web_user_clientidsocid ON labtcs.labtcs_web_user USING btree (social_id, client_id) WHERE (social_id IS NOT NULL);


--
