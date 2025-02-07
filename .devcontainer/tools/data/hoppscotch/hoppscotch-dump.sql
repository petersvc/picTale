--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 17.2 (Debian 17.2-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: ReqType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ReqType" AS ENUM (
    'REST',
    'GQL'
);


ALTER TYPE public."ReqType" OWNER TO postgres;

--
-- Name: TeamMemberRole; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."TeamMemberRole" AS ENUM (
    'OWNER',
    'VIEWER',
    'EDITOR'
);


ALTER TYPE public."TeamMemberRole" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Account" (
    id text NOT NULL,
    "userId" text NOT NULL,
    provider text NOT NULL,
    "providerAccountId" text NOT NULL,
    "providerRefreshToken" text,
    "providerAccessToken" text,
    "providerScope" text,
    "loggedIn" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Account" OWNER TO postgres;

--
-- Name: InfraConfig; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."InfraConfig" (
    id text NOT NULL,
    name text NOT NULL,
    value text,
    "createdOn" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedOn" timestamp(3) without time zone NOT NULL,
    "isEncrypted" boolean DEFAULT false NOT NULL,
    "lastSyncedEnvFileValue" text
);


ALTER TABLE public."InfraConfig" OWNER TO postgres;

--
-- Name: InfraToken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."InfraToken" (
    id text NOT NULL,
    "creatorUid" text NOT NULL,
    label text NOT NULL,
    token text NOT NULL,
    "expiresOn" timestamp(3) without time zone,
    "createdOn" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedOn" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."InfraToken" OWNER TO postgres;

--
-- Name: InvitedUsers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."InvitedUsers" (
    "adminUid" text NOT NULL,
    "adminEmail" text NOT NULL,
    "inviteeEmail" text NOT NULL,
    "invitedOn" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."InvitedUsers" OWNER TO postgres;

--
-- Name: PersonalAccessToken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PersonalAccessToken" (
    id text NOT NULL,
    "userUid" text NOT NULL,
    label text NOT NULL,
    token text NOT NULL,
    "expiresOn" timestamp(3) without time zone,
    "createdOn" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedOn" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."PersonalAccessToken" OWNER TO postgres;

--
-- Name: Shortcode; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Shortcode" (
    id text NOT NULL,
    request jsonb NOT NULL,
    "creatorUid" text,
    "createdOn" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "embedProperties" jsonb,
    "updatedOn" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Shortcode" OWNER TO postgres;

--
-- Name: Team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Team" (
    id text NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."Team" OWNER TO postgres;

--
-- Name: TeamCollection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TeamCollection" (
    id text NOT NULL,
    "parentID" text,
    "teamID" text NOT NULL,
    title text NOT NULL,
    "orderIndex" integer NOT NULL,
    "createdOn" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedOn" timestamp(3) without time zone NOT NULL,
    data jsonb
);


ALTER TABLE public."TeamCollection" OWNER TO postgres;

--
-- Name: TeamEnvironment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TeamEnvironment" (
    id text NOT NULL,
    "teamID" text NOT NULL,
    name text NOT NULL,
    variables jsonb NOT NULL
);


ALTER TABLE public."TeamEnvironment" OWNER TO postgres;

--
-- Name: TeamInvitation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TeamInvitation" (
    id text NOT NULL,
    "teamID" text NOT NULL,
    "creatorUid" text NOT NULL,
    "inviteeEmail" text NOT NULL,
    "inviteeRole" public."TeamMemberRole" NOT NULL
);


ALTER TABLE public."TeamInvitation" OWNER TO postgres;

--
-- Name: TeamMember; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TeamMember" (
    id text NOT NULL,
    role public."TeamMemberRole" NOT NULL,
    "userUid" text NOT NULL,
    "teamID" text NOT NULL
);


ALTER TABLE public."TeamMember" OWNER TO postgres;

--
-- Name: TeamRequest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TeamRequest" (
    id text NOT NULL,
    "collectionID" text NOT NULL,
    "teamID" text NOT NULL,
    title text NOT NULL,
    request jsonb NOT NULL,
    "orderIndex" integer NOT NULL,
    "createdOn" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedOn" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."TeamRequest" OWNER TO postgres;

--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    uid text NOT NULL,
    "displayName" text,
    email text,
    "photoURL" text,
    "isAdmin" boolean DEFAULT false NOT NULL,
    "refreshToken" text,
    "currentRESTSession" jsonb,
    "currentGQLSession" jsonb,
    "createdOn" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "lastLoggedOn" timestamp(3) without time zone,
    "lastActiveOn" timestamp(3) without time zone
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: UserCollection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserCollection" (
    id text NOT NULL,
    "parentID" text,
    "userUid" text NOT NULL,
    title text NOT NULL,
    "orderIndex" integer NOT NULL,
    type public."ReqType" NOT NULL,
    "createdOn" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedOn" timestamp(3) without time zone NOT NULL,
    data jsonb
);


ALTER TABLE public."UserCollection" OWNER TO postgres;

--
-- Name: UserEnvironment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserEnvironment" (
    id text NOT NULL,
    "userUid" text NOT NULL,
    name text,
    variables jsonb NOT NULL,
    "isGlobal" boolean NOT NULL
);


ALTER TABLE public."UserEnvironment" OWNER TO postgres;

--
-- Name: UserHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserHistory" (
    id text NOT NULL,
    "userUid" text NOT NULL,
    "reqType" public."ReqType" NOT NULL,
    request jsonb NOT NULL,
    "responseMetadata" jsonb NOT NULL,
    "isStarred" boolean NOT NULL,
    "executedOn" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."UserHistory" OWNER TO postgres;

--
-- Name: UserRequest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserRequest" (
    id text NOT NULL,
    "collectionID" text NOT NULL,
    "userUid" text NOT NULL,
    title text NOT NULL,
    request jsonb NOT NULL,
    type public."ReqType" NOT NULL,
    "orderIndex" integer NOT NULL,
    "createdOn" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedOn" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."UserRequest" OWNER TO postgres;

--
-- Name: UserSettings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserSettings" (
    id text NOT NULL,
    "userUid" text NOT NULL,
    properties jsonb NOT NULL,
    "updatedOn" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."UserSettings" OWNER TO postgres;

--
-- Name: VerificationToken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."VerificationToken" (
    "deviceIdentifier" text NOT NULL,
    token text NOT NULL,
    "userUid" text NOT NULL,
    "expiresOn" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."VerificationToken" OWNER TO postgres;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Data for Name: Account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Account" (id, "userId", provider, "providerAccountId", "providerRefreshToken", "providerAccessToken", "providerScope", "loggedIn") FROM stdin;
\.


--
-- Data for Name: InfraConfig; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."InfraConfig" (id, name, value, "createdOn", "updatedOn", "isEncrypted", "lastSyncedEnvFileValue") FROM stdin;
\.


--
-- Data for Name: InfraToken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."InfraToken" (id, "creatorUid", label, token, "expiresOn", "createdOn", "updatedOn") FROM stdin;
\.


--
-- Data for Name: InvitedUsers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."InvitedUsers" ("adminUid", "adminEmail", "inviteeEmail", "invitedOn") FROM stdin;
\.


--
-- Data for Name: PersonalAccessToken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PersonalAccessToken" (id, "userUid", label, token, "expiresOn", "createdOn", "updatedOn") FROM stdin;
\.


--
-- Data for Name: Shortcode; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Shortcode" (id, request, "creatorUid", "createdOn", "embedProperties", "updatedOn") FROM stdin;
\.


--
-- Data for Name: Team; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Team" (id, name) FROM stdin;
\.


--
-- Data for Name: TeamCollection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TeamCollection" (id, "parentID", "teamID", title, "orderIndex", "createdOn", "updatedOn", data) FROM stdin;
\.


--
-- Data for Name: TeamEnvironment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TeamEnvironment" (id, "teamID", name, variables) FROM stdin;
\.


--
-- Data for Name: TeamInvitation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TeamInvitation" (id, "teamID", "creatorUid", "inviteeEmail", "inviteeRole") FROM stdin;
\.


--
-- Data for Name: TeamMember; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TeamMember" (id, role, "userUid", "teamID") FROM stdin;
\.


--
-- Data for Name: TeamRequest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TeamRequest" (id, "collectionID", "teamID", title, request, "orderIndex", "createdOn", "updatedOn") FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (uid, "displayName", email, "photoURL", "isAdmin", "refreshToken", "currentRESTSession", "currentGQLSession", "createdOn", "lastLoggedOn", "lastActiveOn") FROM stdin;
\.


--
-- Data for Name: UserCollection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserCollection" (id, "parentID", "userUid", title, "orderIndex", type, "createdOn", "updatedOn", data) FROM stdin;
\.


--
-- Data for Name: UserEnvironment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserEnvironment" (id, "userUid", name, variables, "isGlobal") FROM stdin;
\.


--
-- Data for Name: UserHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserHistory" (id, "userUid", "reqType", request, "responseMetadata", "isStarred", "executedOn") FROM stdin;
\.


--
-- Data for Name: UserRequest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserRequest" (id, "collectionID", "userUid", title, request, type, "orderIndex", "createdOn", "updatedOn") FROM stdin;
\.


--
-- Data for Name: UserSettings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserSettings" (id, "userUid", properties, "updatedOn") FROM stdin;
\.


--
-- Data for Name: VerificationToken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."VerificationToken" ("deviceIdentifier", token, "userUid", "expiresOn") FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
c9a941a4-df7f-4ea4-96d1-b2a375cf81dd	55ac866ba995f82fd03bcb3ade3a0b28b26b3de7d18c418a19594fb4f5633523	2024-12-06 22:11:41.441732+00	20230406064219_init	\N	\N	2024-12-06 22:11:41.408484+00	1
cdc48894-16ef-4e1e-a2fc-435ee8195b32	98a3cc16a994d12f112c7a0d30bc7ba7d0c4806a98371e39edf11b774b362a02	2024-12-06 22:11:41.448344+00	20231106120154_embeds_addition	\N	\N	2024-12-06 22:11:41.443164+00	1
9d05037a-222f-466d-9f1c-b2b41ea30080	86e3efdc2c3d86bd754801ea96a33f6f992bc81c294132672dc0009815711fb4	2024-12-06 22:11:41.454873+00	20231124104640_infra_config	\N	\N	2024-12-06 22:11:41.449785+00	1
b51557d2-2887-411f-b28d-d02b260b0f9c	c20d3151e3111caf7e83441056c78a4770b9e22c77c22aec718703eddca88dab	2024-12-06 22:11:41.460861+00	20231130082054_collection_headers	\N	\N	2024-12-06 22:11:41.456175+00	1
9381767c-4c04-4122-ab9a-30936457af11	4c29ad8a60a07312deac52de92ff51a3cbbe4972ea3d06fc27b2024b6aa5ed2c	2024-12-06 22:11:41.482734+00	20240226053141_full_text_search_additions	\N	\N	2024-12-06 22:11:41.462617+00	1
962a3e00-f985-4b20-8120-f6ed77f7f757	340491af5a7caab0c5a7f0fa6e1966e2b026589e7c51ac6a9102edf34f924ba9	2024-12-06 22:11:41.49002+00	20240519093155_add_last_logged_on_to_user	\N	\N	2024-12-06 22:11:41.484755+00	1
ebdfe4a5-752e-42cc-973e-d1dfd1f31677	0ff7cde8735d39081ea6cb7bb625a4acdcb7e4dfdd3b977e22ba686ccaaaae95	2024-12-06 22:11:41.499941+00	20240520091033_personal_access_tokens	\N	\N	2024-12-06 22:11:41.492069+00	1
c5bf167e-b247-4b99-a64b-c8f595a2a4f7	b43a1b3d03336f405900feb86c6b2fae5e0bb743bb434bc99f15f645e9458da3	2024-12-06 22:11:41.505867+00	20240621062554_user_last_active_on	\N	\N	2024-12-06 22:11:41.501493+00	1
3d5f63f2-2403-45b8-a582-946c0252117b	9416fb2bc23f404b24d2a9ea7296a269bea8cdff97382d60dd81a5de477a453f	2024-12-06 22:11:41.511455+00	20240725043411_infra_config_encryption	\N	\N	2024-12-06 22:11:41.507354+00	1
dca4d79f-b008-43a3-a542-70194f7ecd10	7f2ff872e813178024ddf5a9bbca112c4b6f6a1a2aca48428db555f0353f6cf1	2024-12-06 22:11:41.521593+00	20240726121956_infra_token	\N	\N	2024-12-06 22:11:41.512969+00	1
995dfca5-5825-4f61-8066-a005be3bc560	bec713baec10b342ee9fc6a590a295bae308036285a118775a810b59bebd58e0	2024-12-06 22:11:41.528359+00	20241118054346_infra_config_sync_with_env_file	\N	\N	2024-12-06 22:11:41.52332+00	1
\.


--
-- Name: Account Account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_pkey" PRIMARY KEY (id);


--
-- Name: InfraConfig InfraConfig_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InfraConfig"
    ADD CONSTRAINT "InfraConfig_pkey" PRIMARY KEY (id);


--
-- Name: InfraToken InfraToken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InfraToken"
    ADD CONSTRAINT "InfraToken_pkey" PRIMARY KEY (id);


--
-- Name: PersonalAccessToken PersonalAccessToken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PersonalAccessToken"
    ADD CONSTRAINT "PersonalAccessToken_pkey" PRIMARY KEY (id);


--
-- Name: Shortcode Shortcode_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Shortcode"
    ADD CONSTRAINT "Shortcode_pkey" PRIMARY KEY (id);


--
-- Name: TeamCollection TeamCollection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamCollection"
    ADD CONSTRAINT "TeamCollection_pkey" PRIMARY KEY (id);


--
-- Name: TeamEnvironment TeamEnvironment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamEnvironment"
    ADD CONSTRAINT "TeamEnvironment_pkey" PRIMARY KEY (id);


--
-- Name: TeamInvitation TeamInvitation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamInvitation"
    ADD CONSTRAINT "TeamInvitation_pkey" PRIMARY KEY (id);


--
-- Name: TeamMember TeamMember_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamMember"
    ADD CONSTRAINT "TeamMember_pkey" PRIMARY KEY (id);


--
-- Name: TeamRequest TeamRequest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamRequest"
    ADD CONSTRAINT "TeamRequest_pkey" PRIMARY KEY (id);


--
-- Name: Team Team_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Team"
    ADD CONSTRAINT "Team_pkey" PRIMARY KEY (id);


--
-- Name: UserCollection UserCollection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserCollection"
    ADD CONSTRAINT "UserCollection_pkey" PRIMARY KEY (id);


--
-- Name: UserEnvironment UserEnvironment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserEnvironment"
    ADD CONSTRAINT "UserEnvironment_pkey" PRIMARY KEY (id);


--
-- Name: UserHistory UserHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserHistory"
    ADD CONSTRAINT "UserHistory_pkey" PRIMARY KEY (id);


--
-- Name: UserRequest UserRequest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRequest"
    ADD CONSTRAINT "UserRequest_pkey" PRIMARY KEY (id);


--
-- Name: UserSettings UserSettings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserSettings"
    ADD CONSTRAINT "UserSettings_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (uid);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Account_provider_providerAccountId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Account_provider_providerAccountId_key" ON public."Account" USING btree (provider, "providerAccountId");


--
-- Name: InfraConfig_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "InfraConfig_name_key" ON public."InfraConfig" USING btree (name);


--
-- Name: InfraToken_token_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "InfraToken_token_key" ON public."InfraToken" USING btree (token);


--
-- Name: InvitedUsers_inviteeEmail_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "InvitedUsers_inviteeEmail_key" ON public."InvitedUsers" USING btree ("inviteeEmail");


--
-- Name: PersonalAccessToken_token_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "PersonalAccessToken_token_key" ON public."PersonalAccessToken" USING btree (token);


--
-- Name: Shortcode_id_creatorUid_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Shortcode_id_creatorUid_key" ON public."Shortcode" USING btree (id, "creatorUid");


--
-- Name: Shortcode_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Shortcode_id_key" ON public."Shortcode" USING btree (id);


--
-- Name: TeamCollection_title_trgm_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "TeamCollection_title_trgm_idx" ON public."TeamCollection" USING gin (title public.gin_trgm_ops);


--
-- Name: TeamInvitation_teamID_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "TeamInvitation_teamID_idx" ON public."TeamInvitation" USING btree ("teamID");


--
-- Name: TeamInvitation_teamID_inviteeEmail_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "TeamInvitation_teamID_inviteeEmail_key" ON public."TeamInvitation" USING btree ("teamID", "inviteeEmail");


--
-- Name: TeamMember_teamID_userUid_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "TeamMember_teamID_userUid_key" ON public."TeamMember" USING btree ("teamID", "userUid");


--
-- Name: TeamRequest_title_trgm_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "TeamRequest_title_trgm_idx" ON public."TeamRequest" USING gin (title public.gin_trgm_ops);


--
-- Name: UserSettings_userUid_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "UserSettings_userUid_key" ON public."UserSettings" USING btree ("userUid");


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: VerificationToken_deviceIdentifier_token_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "VerificationToken_deviceIdentifier_token_key" ON public."VerificationToken" USING btree ("deviceIdentifier", token);


--
-- Name: VerificationToken_token_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "VerificationToken_token_key" ON public."VerificationToken" USING btree (token);


--
-- Name: Account Account_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(uid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: InvitedUsers InvitedUsers_adminUid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."InvitedUsers"
    ADD CONSTRAINT "InvitedUsers_adminUid_fkey" FOREIGN KEY ("adminUid") REFERENCES public."User"(uid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PersonalAccessToken PersonalAccessToken_userUid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PersonalAccessToken"
    ADD CONSTRAINT "PersonalAccessToken_userUid_fkey" FOREIGN KEY ("userUid") REFERENCES public."User"(uid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Shortcode Shortcode_creatorUid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Shortcode"
    ADD CONSTRAINT "Shortcode_creatorUid_fkey" FOREIGN KEY ("creatorUid") REFERENCES public."User"(uid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: TeamCollection TeamCollection_parentID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamCollection"
    ADD CONSTRAINT "TeamCollection_parentID_fkey" FOREIGN KEY ("parentID") REFERENCES public."TeamCollection"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: TeamCollection TeamCollection_teamID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamCollection"
    ADD CONSTRAINT "TeamCollection_teamID_fkey" FOREIGN KEY ("teamID") REFERENCES public."Team"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TeamEnvironment TeamEnvironment_teamID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamEnvironment"
    ADD CONSTRAINT "TeamEnvironment_teamID_fkey" FOREIGN KEY ("teamID") REFERENCES public."Team"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TeamInvitation TeamInvitation_teamID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamInvitation"
    ADD CONSTRAINT "TeamInvitation_teamID_fkey" FOREIGN KEY ("teamID") REFERENCES public."Team"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TeamMember TeamMember_teamID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamMember"
    ADD CONSTRAINT "TeamMember_teamID_fkey" FOREIGN KEY ("teamID") REFERENCES public."Team"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TeamRequest TeamRequest_collectionID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamRequest"
    ADD CONSTRAINT "TeamRequest_collectionID_fkey" FOREIGN KEY ("collectionID") REFERENCES public."TeamCollection"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TeamRequest TeamRequest_teamID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TeamRequest"
    ADD CONSTRAINT "TeamRequest_teamID_fkey" FOREIGN KEY ("teamID") REFERENCES public."Team"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserCollection UserCollection_parentID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserCollection"
    ADD CONSTRAINT "UserCollection_parentID_fkey" FOREIGN KEY ("parentID") REFERENCES public."UserCollection"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserCollection UserCollection_userUid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserCollection"
    ADD CONSTRAINT "UserCollection_userUid_fkey" FOREIGN KEY ("userUid") REFERENCES public."User"(uid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserEnvironment UserEnvironment_userUid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserEnvironment"
    ADD CONSTRAINT "UserEnvironment_userUid_fkey" FOREIGN KEY ("userUid") REFERENCES public."User"(uid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserHistory UserHistory_userUid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserHistory"
    ADD CONSTRAINT "UserHistory_userUid_fkey" FOREIGN KEY ("userUid") REFERENCES public."User"(uid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserRequest UserRequest_collectionID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRequest"
    ADD CONSTRAINT "UserRequest_collectionID_fkey" FOREIGN KEY ("collectionID") REFERENCES public."UserCollection"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UserRequest UserRequest_userUid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRequest"
    ADD CONSTRAINT "UserRequest_userUid_fkey" FOREIGN KEY ("userUid") REFERENCES public."User"(uid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserSettings UserSettings_userUid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserSettings"
    ADD CONSTRAINT "UserSettings_userUid_fkey" FOREIGN KEY ("userUid") REFERENCES public."User"(uid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: VerificationToken VerificationToken_userUid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VerificationToken"
    ADD CONSTRAINT "VerificationToken_userUid_fkey" FOREIGN KEY ("userUid") REFERENCES public."User"(uid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

